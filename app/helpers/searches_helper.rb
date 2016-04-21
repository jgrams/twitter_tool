module SearchesHelper
  #take an array of arrays(sort_by performed on hashes with word count values)
  #will transform into circle radius and return an integer, so maps to 20-100 rather than from 0
  def scale_range_to_percentage(array)
    max = array[0][1].to_i
    min = array[-1][1].to_i
    @word_count_percentages = []
    binding.pry
    array.each { |object| @word_count_percentages.push (object[1].to_f-min)/(max-min) * (100-20) + 20 }
    binding.pry
    @word_count_percentages
  end
end
