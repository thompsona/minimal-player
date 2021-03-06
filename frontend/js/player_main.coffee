# Run this command from minimal-player/ to continuously monitor & compile files:
# coffee --compile --watch --output static/js/ frontend/js/

window.toggleSubtitles = ->
  $('#subtitle-container').slideToggle
    duration: 400
    complete: ->
      $('subtitle-container').css('display', 'none')
      util.maintainAspect()

window.toggleComments = ->
  console.log('toggle comments')
  $('#comment-container').slideToggle
    duration: 400
    complete: ->
      $('comment-container').css('display', 'none')
      util.maintainAspect()




$ ->
    util.maintainAspect()

    # Create a scene controller
    window.sceneController = new lessonplan.SceneController(sceneList)

    # Create a new timeline object, and associate it with the scene
    timeline = new lessonplan.Timeline('#timeline-controls', window.sceneController)

    if window.showSubtitles? and window.showSubtitles
      window.toggleSubtitles()

    #if window.showComments? and window.showSubtitles
    #  window.toggleComments()


    #Create a handler for "submitComment"
    $('#comment-button').on('click', ->
        #change the username to refer to an actual user
        username = 'testuser'
        timestamp = timeline.currentTimelineURI()
        text = $('input[name=comment-input]').val()
        comment = 
                    username: 'testuser',
                    timestamp: timestamp, 
                    text: text

        $.ajax({
          type: "POST",
          url: "/comments",
          data: JSON.stringify(comment),
          contentType:"application/json; charset=utf-8",
          dataType: "json",
          success: ->
            alert('successful post')
        });
    )



    # Test reportOnDeck
    console.log "~~~~~~~~~ REPORT ON DECK ~~~~~~~~~~~~~"
    reportOnDeck = (ondecks) ->
        console.log ondecks

    timeline.onNewOnDeckURIs(reportOnDeck)

    $('#commentButton').on('click', ->
      newText = $('#commentField').val()
      $('#comment-container').append('<div class="comment">' + newText + '</div>')
    )

    # # Test current URI (@ 1 sec intervals)
    # console.log "~~~~~~~~~ CURRENT URI ~~~~~~~~~~~~~"
    # chirp = ->
    #     currentURI = timeline.currentTimelineURI() 
    #     console.log 'Current URI'
    #     console.log currentURI
    #     console.log timeline.timelineURItoX(currentURI) + '%'

    # setInterval(chirp, 1000)


    # Test registering a callback
    # console.log "~~~~~~~~~ INSTALL TIMED CALLBACK ~~~~~~~~~~~~~"
    # timeline.atTimelineURI('fleet_week/5.0', -> alert('This is an installed callback!'))

    window.timeline = timeline

