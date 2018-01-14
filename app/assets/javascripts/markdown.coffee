window.load_markdown_for_text_area = ->
  $(".mark").markdown
    autofocus: true

$(document).on 'ready', ->
  load_markdown_for_text_area()
