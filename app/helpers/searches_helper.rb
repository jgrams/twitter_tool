module SearchesHelper
  #take an array of arrays(sort_by performed on hashes with word count values)
  #returns a pixel size on a scale of 200 for the svg cicle to be built at, so maps to 40-400
  #rather than from 0
  def scale_word_count_to_pixel_size(object, min, max)
    ((object[1].to_f-min)/(max-min) * (200-60) + 60).to_i.to_s.concat('px')
  end

  #create SVG nested elements
  def nest_svg_divs(content, pixel_size)
    content_tag('div', style: ["width: #{pixel_size};", "height: #{pixel_size};"], class: "svg-wrapper") do
      content_tag('svg', class: "svg-circle") do
        content_tag('text', "#{content[0]}", class: "svg-text")
      end
    end
   end

end