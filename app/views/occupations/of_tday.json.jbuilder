json.reserved_list do
  @rooms.each do |room|
    json.set! room.id do
      json.array! @reserved_list[room.id.to_s] do |ary|
          json.mn   ary[0]
          if ary[1] == 0
            json.oid  0
            json.uid  0
          else
            json.oid  ary[1][0]
            json.uid  ary[1][1]
          end
      end 
    end
  end
end