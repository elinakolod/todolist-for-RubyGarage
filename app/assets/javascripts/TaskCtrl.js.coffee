# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
angular
	.module("toDoList", ["ngResource", "ui", "ngFileUpload"])
	.controller('TaskCtrl', ($scope, $resource, Upload) ->
		$scope.init = ->
			$scope.newTask = {}
			$scope.editProject = {}
			$scope.editTask = {}
			$scope.newComment = {}
		csrf_token = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

		Project = $resource('/projects/:id.json', {id: '@id'}, {'update': {method:'PUT'}, 'remove': {method: 'DELETE', headers: {'Content-Type': 'application/json'}}})
		Task = $resource('/tasks/:id.json', {id: '@id'}, {'update': {method:'PUT'}, 'remove': {method: 'DELETE', headers: {'Content-Type': 'application/json'}}})
		Comment = $resource('/comments/:id.json', {id: '@id'}, {'update': {method:'PUT'}, 'remove': {method: 'DELETE', headers: {'Content-Type': 'application/json'}}})
		Attachment = $resource('/attachments/:id.json', {id: '@id'}, {'remove': {method: 'DELETE', headers: {'Content-Type': 'application/json', 'X-CSRF-TOKEN': csrf_token}}})
		User = $resource('/users/:id.json', {id: '@id'}, {'query': {method:'GET', isArray:false}})
		$scope.user = User.query()
		$scope.projects = Project.query()
		
		$scope.sortableOptions = (tasks) ->
			arr = jQuery.map( tasks, ( task, i ) ->
				( task.id )
			)
			stop: (e, ui) ->
				if ui.item.sortable.resort
					newArrayOfTasks = ui.item.sortable.resort.$$lastCommittedViewValue
					tasks = newArrayOfTasks
					angular.forEach(tasks, (task, i) ->
						task.position = i
						Task.update(task)
					)	
			axis: 'y'

		$scope.AddTask = (parent) ->
			task = Task.save({name: $scope.newTask.name[parent.id], project_id: parent.id})
			if parent.tasks == undefined
				parent.tasks = []
			parent.tasks.push(task)
			$scope.newTask = {}
			
		$scope.SetDone = (task) ->
			task.done = !task.done
			Task.update(task)
			
		$scope.EditTask = (task) ->
			if $scope.editTask.name != undefined
				task.name = $scope.editTask.name[task.id]
			if $scope.editTask.deadline != undefined
				task.deadline = $scope.editTask.deadline
			if $scope.editTask.name != undefined || $scope.editTask.deadline != undefined
				Task.update(task)
				$scope.editTask = {}
			
		$scope.DestroyTask = (task, parent) ->
			Task.remove({ id: task.id }, ->
				parent.tasks.splice(parent.tasks.indexOf(task), 1)
			)
			
		$scope.GetDate = (date) ->
			if date
				date = new Date(date)
				date.setDate(date.getDate() + 1)

		$scope.AddComment = (task) ->
			comment = Comment.save({content: $scope.newComment.content[task.id], task_id: task.id})
			if task.comments == undefined
				task.comments = []
			task.comments.unshift(comment)
			$scope.newComment = {}
			
		$scope.DestroyComment = (comment, task) ->
			Comment.remove({ id: comment.id }, ->
				task.comments.splice(task.comments.indexOf(comment), 1)
			)

		$scope.upload = (files, task) ->
			if (files && files.length)
				for i in [0...files.length]
					file = files[i]
					if (!file.$error)
						Upload.upload(
							url: '/attachments.json',
							method: 'POST',
							headers:
								'Content-Type': file.type,
								'X-CSRF-TOKEN': csrf_token,
							fields: { name: file.name, file: file, task_id: task.id, content_type: file.type }
							formDataAppender: (fd, key, val) ->
								if (angular.isArray(val))
									angular.forEach(val, (v) ->
										fd.append('attachment['+key+']', v)
									)
								else
									fd.append('attachment['+key+']', val)
						).success( (json) ->
							task.attachments = json
						)

		$scope.DestroyAttachment = (attachment, task) ->
			Attachment.remove({ id: attachment.id }, ->
				task.attachments.splice(task.attachments.indexOf(attachment), 1)
		)

		$scope.NewProject = ->
			project = Project.save({name: "New Project", user_id: $scope.user.id})
			#$scope.projects.push(project)
			$scope.projects = Project.query()

		$scope.UpdateProject = (project) ->
			project.name = $scope.editProject.name[project.id]
			Project.update(project)
			$('.project_name.' + project.id + ' input').toggleClass("hidden")
			$('.project_name.' + project.id + ' span').toggleClass("hidden")
			return false
			
		$scope.DestroyProject = (project) ->
			Project.remove({ id: project.id }, ->
				$scope.projects.splice($scope.projects.indexOf(project), 1)
			)
)
