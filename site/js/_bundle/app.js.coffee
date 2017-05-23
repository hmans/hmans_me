initPage = ->
  $("a.embed").oembed null,
    embedMethod: "replace"

  $('pre code').each (i, block) ->
    hljs.highlightBlock(block)

$(document).on "ready", ->
  initPage()
