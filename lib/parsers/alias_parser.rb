module KMExport
  def self.alias_parser(jsonfile)
    input = IO.open(IO.sysopen(jsonfile))
    alias_filename = Time.now.to_i.to_s + "_aliases.json"
    new_filename = Time.now.to_i.to_s + "_result.json"
    File.open(alias_filename, "w+").close
    File.open(new_filename, "w+").close
    alias_output = IO.open(IO.sysopen(alias_filename, "w"), "w")
    data_output = IO.open(IO.sysopen(new_filename, "w"), "w")

    until input.eof?
      encodedline = input.readline.encode( "UTF-8", "binary", :invalid => :replace, :undef => :replace)
      line = JSON.parse(encodedline)
      if line["_p2"]
        alias_output.write(JSON.generate(line))
        alias_output.write("\n")
      else
        data_output.write(JSON.generate(line))
        data_output.write("\n")
      end
    end

    input.close
    alias_output.close
    data_output.close

    File.delete(jsonfile)
  end
end