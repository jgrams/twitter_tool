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
    pixel_maximum = 250
    pixel_minimum = 85
    ((item[1].to_f-range_minimum)/(range_maximum-range_minimum) * (pixel_maximum-pixel_minimum) + pixel_minimum).to_i.to_s.concat('px')
  end

  def text_length(item)
    if item[0].length >= 10
      item[0].length * 4
    elsif item[0].length == 5  
      item[0].length * 4
    elsif item[0].length
      item[0].length * 5
    end
  end
  #create divs to contain the svg and text elements, curently passing in some a bunch of style elements also
  #for formatttign the svg text and the width of the svgs
  def nest_svg_divs(item, range_minimum, range_maximum)
    pixel_size = scale_word_count_to_pixel_size(item, range_minimum, range_maximum)
    content_tag('div', style: ["width: #{pixel_size};", "height: #{pixel_size};"], class: "svg-wrapper") do
      content_tag('svg', viewBox: "-#{text_length(item)} -8 #{text_length(item) * 2} 16", preserveAspectRatio: "xMidYMid meet", class: "svg-circle") do
        content_tag('text', "#{item[0]}", class: "svg-text") +
        content_tag('text', "#{item[1]}", class: "svg-text-hidden")
      end
    end
  end

end