jQuery ->
  $(".show span").click ->
    for item in $(this).parent().prev().children()
      $(item).removeClass("hidden")
    $(this).hide()

  $(".what").tagit({allowSpaces: true, availableTags: ["PHP", "Python", "jQuery"]})
  $(".where").tagit({allowSpaces: true, availableTags: ["Melbourne", "New York"]})