module SearchesHelper
  #take an array of arrays(sort_by performed on hashes with word count values)
  #returns a string of pixel size in format "Xpx" for the svg cicle to be built at, 
  #so maps to 60-200 rather than from 0
  def scale_word_count_to_pixel_size(object, min, max)
    range_maximum = 200
    range_minimum = 60
    ((object[1].to_f-min)/(max-min) * (range_maximum-range_minimum) + range_minimum).to_i.to_s.concat('px')
  end

  #create divs to contain the svg and text elements
  def nest_svg_divs(content, pixel_size)
    content_tag('div', style: ["width: #{pixel_size};", "height: #{pixel_size};"], class: "svg-wrapper") do
      content_tag('svg', class: "svg-circle") do
        content_tag('text', "#{content[0]}", class: "svg-text")
      end
    end
   end

end