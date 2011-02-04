namespace :midi do
  desc "Parse all midi files in ENV['MIDI_DIR']"
  task :parse => :environment do
    Dir.chdir(ENV['MIDI_DIR'])
    Dir.glob("*.mid").sort.each do |midi_file|
      system("midicsv #{midi_file} #{midi_file}.csv")
      File.open("#{midi_file}.csv") do |file|
        puts "Parsing #{midi_file}"
        parser = Midiparser::Parser.new(file)
        parser.parse
      end
      File.delete("#{midi_file}.csv")
    end
  end
end
