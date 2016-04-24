module SearchesHelper
  #take an array of arrays(sort_by performed on hashes with word count values)
  #will transform into circle radius and return an integer, so maps to 20-100 rather than from 0
  def scale_range_to_percentage(object, min, max)
    ((object[1].to_f-min)/(max-min) * (100-20) + 20).to_i.to_s.concat('%')
  end
end
