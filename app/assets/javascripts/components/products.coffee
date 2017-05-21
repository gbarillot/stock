class @Products

  @create = (el) ->
    form = $(el)

    $.ajax
      url: form.attr('action')
      type: "post"
      dataType: "json"
      data:
        product:
          name: form.find("[name='product[name]']").val()
          reference: form.find("[name='product[reference]']").val()
          quantity: form.find("[name='product[quantity]']").val()
          position: form.find("[name='product[position]']").val()

      success: (data) ->
        if location.pathname != '/'
          window.location.href = '/'
        else
          product = Products.add(data.product)
          $('#products').append(product)
          $('#createProduct').modal('hide')
        return false

      error: (response) ->
        form.find('[data-signin-errors]').text('')
        for key, error of response.responseJSON.errors
          form.find("[data-product-errors='"+key+"']").text(error)
          form.find("[data-product-errors='"+key+"']").fadeIn()
        return false
    return false

  @add = (product) ->
    out  = "<div class='col-md-4'>"
    out += "<div class='card'>"
    out += "<div class='card-block'>"
    out += "<h4 class='card-title'><a href='/products/#{product.id}'>#{product.name}</a></h4>"
    out += "<hr>"
    out += "<p class='card-text'>"
    out += "Ref: <a href='/products/#{product.id}'>#{product.reference}</a>"
    out += "<br>"
    out += "Emplacement: <a href='/positions/#{product.position}'>#{product.position}</a>"
    out += "<br>"
    out += "Stock:"
    out += "<strong>#{product.quantity}</strong>"
    out += "</p>"
    out += "</div>"
    out += "</div>"
    out += "</div>"

    return out

  @pull = (el) ->
    that = $(el)
    $.ajax
      url: '/products'
      type: 'get'
      dataType: 'json'
      success: (data) ->
        out = ''
        for product in data.products
          out += Products.add(product)
        $('#products').html(out)

  @search = (el) ->
    that = $(el)
    if that.val().length < 3 && that.val().length > 0
      return false

    $.ajax
      url: '/products/search'
      type: 'post'
      dataType: 'json'
      data:
        q: that.val()
      success: (data) ->
        out = ''
        for product in data.products
          out += Products.add(product)
        $('#products').html(out)

  @update = (el) ->
    form = $(el)

    $.ajax
      url: form.attr('action')
      type: "put"
      dataType: "json"
      data:
        product:
          name: form.find("[name='product[name]']").val()
          reference: form.find("[name='product[reference]']").val()
          quantity: form.find("[name='product[quantity]']").val()
          notes: form.find("[name='product[notes]']").val()

      success: (data) ->
        alert "Produit mis à jour"
        return false

      error: (response) ->
        form.find('[data-signin-errors]').text('')
        for key, error of response.responseJSON.errors
          form.find("[data-product-errors='"+key+"']").text(error)
          form.find("[data-product-errors='"+key+"']").fadeIn()
        return false
    return false

#$ ->
$(document).on "turbolinks:load", ->
  Listen.to('Products')
  $('#products').each ->
    Products.pull(this)

  $('#search').keyup ->
    Products.search(this)

  $('#search').one 'focus', ->
    if location.pathname != '/'
      window.location.href = '/'

  if location.pathname == '/'
    $('#search').focus()
