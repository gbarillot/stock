class @Listen

  @to = (component) ->
    $("[data-component='#{component}']").each ->
      that = $(this)
      if typeof that.data 'on' != 'undefined'
        that.off(that.data('on')).on(that.data('on'), (e) ->
          if typeof that.data 'do' != 'undefined'
            if($(e.target).closest('a').length)
              e.preventDefault()
            window[ that.data('component') ][ that.data('do') ]( this )
        )

  @on = (str) ->
    selector = ""
    i = 0
    fragments = str.split('.')
    while i < fragments.length
      if selector == ""
        selector += "[data-component='#{fragments[0]}']"
      else
        selector += "[data-#{fragments[i]}='#{fragments[i+1]}']"
        i += 1
      i += 1

    return $(selector)
