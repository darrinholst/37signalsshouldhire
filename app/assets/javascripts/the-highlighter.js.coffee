$$(".questions").first().observe('click', (event) ->
  if event.target.tagName.match(/input/i)
    $(event.target).up("label").highlight()
)

