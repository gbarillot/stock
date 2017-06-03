module ApplicationHelper

  def positions_tree(str)
    out = []
    slug = []
    size = str.split('-').length
    str.split('-').each_with_index do |fragment, i|
      slug.push(fragment)
      prefix = "Allée" if i == 0
      prefix = "Rack" if i == 1
      prefix = "Etage" if i == 2
      prefix = "Emplacement" if i == 3

      if i == size - 1
        out.push("<span>#{prefix} #{fragment}</span>")
      else
        out.push("<span><a href='/#/positions/#{slug.join('-')}'>#{prefix} #{fragment}</a></span>")
      end
    end

    return out.join('').html_safe
  end

  def locations_tree(str)
    out = []
    slug = []
    size = str.split('-').length
    if str.split('-').first == '*'
      out.push("<span>Emplacements</span>")
    else
      out.push("<span><a href='/#/locations/*'>Emplacements</a></span>")

      str.split('-').each_with_index do |fragment, i|
        slug.push(fragment)
        prefix = "Allée" if i == 0
        prefix = "Rack" if i == 1
        prefix = "Etage" if i == 2
        prefix = "Emplacement" if i == 3

        if i == size - 1
          out.push("<span>#{prefix} #{fragment}</span>")
        else
          out.push("<span><a href='/#/locations/#{slug.join('-')}'>#{prefix} #{fragment.upcase}</a></span>")
        end
      end
    end

    return out.join('').html_safe
  end

end
