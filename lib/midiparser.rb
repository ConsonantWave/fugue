module Midiparser
  class Parser
    def initialize(file)
      @file = file
      @piece = Piece.new
    end

    def parse
      @file.each_line do |line|
        data = line.chomp.split(", ")
        parse_line(data)
      end
      @piece.save
    end

    def parse_line(data)
      case data[0]
      when "0"
        # parse header
        if data[2] == "Header"
          header(data[3].to_i, data[4].to_i, data[5].to_i)
        end
      when "1"
        # parse metadata
        metadata(data[2], data[3..-1])
      else
        # parse channel event
        event(data[2], data[0].to_i, data[1].to_i, data[3..-1])
      end
    end

    def header(format, num_tracks, division)
      @piece.division = division
    end

    def metadata(type, args)
      case type
      when "Text_t"
        @piece.title = handle_text(args) 
      when "Tempo"
        @piece.tempo = args[0].to_i
      end # don't handle anything else for now
    end

    def event(type, track, time, args)
      case type
      when "Start_track"
        track_start(track)
      when "End_track"
        track_end(track, time)
      when "Title_t"
        track_title(track, handle_text(args)) 
      when "Note_on_c"
        note_on(track, time, args[1].to_i, args[2].to_i)
      when "Note_off_c"
        note_off(track, time, args[1].to_i)
      end
    end

    def track_start(track)
      @current_track = Track.new
      @current_track.piece = @piece
      @pending_notes = {}
    end

    def track_end(track, time)
      # no functionality needed at this time
    end

    def track_title(track, title)
      @current_track[:title] = title
    end

    def note_on(track, time, note, velocity)
      if velocity == 0
        note_off(track, time, note)
        return
      end

      @pending_notes[note] = time # we have a note on event, we need the note off
    end

    def note_off(track, time, note)
      if @pending_notes.key? note
        @current_track.notes << Note.new(:pitch => note, :start => @pending_notes[note], :length => time - @pending_notes[note])
        @pending_notes.delete(note)
      else
        puts "Off event before on event. track: #{track}, time: #{time}, pitch: #{note}"
      end
    end
    
    # the line splitting above can mess with text output from midicsv,
    # if the text contains commas followed by spaces. Also there are 
    # extraneous quotation marks surrounding the text output that should
    # be removed.
    def handle_text(arr)
      arr.inject { |concatenation, str| concatenation << ", " << str }[1...-1]
    end
  end
end
