module SearchesHelper
  #find the max and min word counts for array of arrays(sort_by performed on hashes with word count values)
  def find_max_and_min_word_count(object)
    @range_minimum = object[-1][1].to_i
    @range_maximum = object[0][1].to_i
  end
  #take an item in an array of arrays(sort_by performed on hashes with word count values)
  #returns a string of pixel size in format "Xpx" for the svg cicle to be built at, 
  #so maps to "80-300px" from whatever word count range there is
  def scale_word_count_to_pixel_size(item, range_minimum, range_maximum)
    pixel_maximum = 300
    pixel_minimum = 80
    ((item[1].to_f-range_minimum)/(range_maximum-range_minimum) * (pixel_maximum-pixel_minimum) + pixel_minimum).to_i.to_s.concat('px')
  end

  #create divs to contain the svg and text elements, curently passing in some style elements also
  def nest_svg_divs(item, range_minimum, range_maximum)
    pixel_size = scale_word_count_to_pixel_size(item, range_minimum, range_maximum)
    content_tag('svg', style: ["width: #{pixel_size};", "height: #{pixel_size};"], class: "svg-wrapper") do
      tag('circle', class: "svg-circle", r:'100%', cx: '50%', cy: '50%', stroke:"black").concat(
      content_tag('text', "#{item[0]}", class: "svg-text", x: "50%", y: "50%", lengthAdjust: "spacingAndGlyphs", textLength: "70%"))
    end
   end

end