class @Positions

  @pull = (el) ->
    that = $(el)

    $.ajax
      url: '/positions'
      type: 'post'
      dataType: 'json'
      data:
        id: that.data('is')
      success: (data) ->
        out = ''
        for product in data.products
          out += Products.add(product)
        $('#positions').html(out)
        $("[data-component='Positions'][data-is='total']").text("#{data.total} references / #{data.items} produits")


$(document).on "turbolinks:load", ->
  Listen.to('Positions')

  $('#positions').each ->
    Positions.pull(this)
