module KMExport
  class Reimporter
    def send_to_KM(json, key)
      KMTS.init(key,
        :use_cron => false, 
        :to_stderr => true)

      logs = JSON.parse(json)
      logs.each do |line|
        send_line_to_KM(line)
        STDOUT.print('.')
      end

      STDOUT.print('Reimportation process completed.')
    end

    def send_line_to_KM(line)
      identity = line.delete("_p")
      second_identity = line.delete("_p2")
      event = line.delete("_n")
      line["_d"] = 1

      KMTS.alias(identity,second_identity) if second_identity
      KMTS.record(identity,event,line) if event
      KMTS.set(identity,line) unless event || second_identity
    end
  end
end