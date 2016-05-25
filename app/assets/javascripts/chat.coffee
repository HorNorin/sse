# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  name = ''
  chatbox = $('#chatbox')
  source = new EventSource('/chats/new')
  source.addEventListener 'message', (e) ->
    appendMessage(e.data)

  $('#chat').hide();
  $('#btn-register').on 'click', (e) ->
    e.preventDefault()
    name = $('#name').val()
    $('#register').hide()
    $('#chat').show();

  $('#btn').on 'click', (e) ->
    e.preventDefault()
    textBox = $('#message')
    message = textBox.val()
    textBox.val('')
    $.ajax({
      url: '/chats',
      method: 'POST',
      data: { user: name, message: message }
    })

  appendMessage = (data) ->
    object = JSON.parse(data)
    node = document.createElement('div')
    node.className = 'chat-message'
    node.innerHTML = "#{object.user}: #{object.message}"
    chatbox.append(node)
