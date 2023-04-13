require 'json'
raw_data = File.read('harmonics.json')

@harmonics = JSON.parse(raw_data)
@available_harmonics = ["C", "D"]

def translate
  set_harmonics
  set_input_tabs
  p parse_tabs
end

def set_harmonics
  set_origin
  set_target
end

def set_origin
  @origin = 'C'
  @origin_harmonic = @harmonics[@origin]
  p "Origin: #{@origin}"
end

def set_target
  @target = 'D'
  @target_harmonic = @harmonics[@target]
  p "Target: #{@target}"
end

def set_input_tabs
  print "Input tabs: "
  @input_tabs = gets
  @input_tabs
end

def parse_tabs
  tabs = @input_tabs.split
  parsed_tabs = '| '
  tabs.each do |tab|
    next parsed_tabs += "#{tab} " if number_tab(tab).zero?

    parsed_tabs += "#{parsed_tab(tab)} "
  end
  parsed_tabs += '|'
  parsed_tabs
end

def number_tab(tab)
    tab.to_i # TODO: by regex
end

def parsed_tab(original)
  note =  origin_note(original)
  target = target_tab(note)
  original.gsub(number_tab(original).to_s, target.to_s)
end

def origin_note(tab)
  n = number_tab(tab).abs
  @origin_harmonic[n.to_s][blow_or_draw(tab)]
end

def blow_or_draw(tab)
  number_tab(tab).positive? ? 'blow' : 'draw'
end

def target_tab(note)
  target = nil
  @target_harmonic.each do |tab, notes|
    next unless tab
    notes.each do |blow_or_draw, t_note|
      next unless tab

      if t_note == note
        target = (blow_or_draw == 'blow' ? 1 : -1) * tab.to_i
      end
    end
  end
  target
end



translate
