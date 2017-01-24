hljs.initHighlightingOnLoad();

initPage = ->
  $("a.embed").oembed null,
    embedMethod: "replace"

$(document).on "turbolinks:load", ->
  initPage()
