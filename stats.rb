# stats.rb

def count_code_lines(file_path)
  lines = File.readlines(file_path)
  lines.reject do |line|
    stripped = line.strip
    # Ignore blank lines, Ruby comments (#), and HTML comments (<!--)
    stripped.empty? || 
      stripped.start_with?('#') || 
      stripped.start_with?('//') || 
      stripped.start_with?('<!--')
  end.size
rescue
  0
end

def process_directory(dir_pattern)
  files = Dir.glob(dir_pattern)
  counts = files.map { |file| count_code_lines(file) }
  [files.size, counts]
end

def categorize(counts)
  buckets = {
    '1–10'    => 0,
    '11–25'   => 0,
    '26–50'   => 0,
    '51–100'  => 0,
    '101–200' => 0,
    '201–400' => 0,
    '401–800' => 0,
    '800+'    => 0
  }

  counts.each do |c|
    case c
    when 1..10     then buckets['1–10'] += 1
    when 11..25    then buckets['11–25'] += 1
    when 26..50    then buckets['26–50'] += 1
    when 51..100   then buckets['51–100'] += 1
    when 101..200  then buckets['101–200'] += 1
    when 201..400  then buckets['201–400'] += 1
    when 401..800  then buckets['401–800'] += 1
    else                buckets['800+'] += 1 if c > 800
    end
  end

  buckets
end

def render_chart(categories)
  max_bar_width = 18 # Compact bar width to fit 3 columns on standard terminal screens

  # Print Header
  header = sprintf("%-9s", "code lines")
  categories.each do |name, data|
    header += sprintf("  %-#{max_bar_width + 10}s", "#{name} (#{data[:file_count]} files)")
  end
  puts header
  puts "-" * header.length

  # Pre-categorize data
  buckets_by_category = categories.transform_values { |v| categorize(v[:counts]) }

  # Print Rows
  buckets_by_category.values.first.keys.each do |range|
    row = sprintf("%-9s", range)

    categories.each do |name, data|
      val = buckets_by_category[name][range]
      pct = data[:file_count] > 0 ? (val.to_f / data[:file_count] * 100) : 0.0
      bar_len = (pct / 100.0 * max_bar_width).round
      bar = "█" * bar_len

      row += sprintf("  %-#{max_bar_width}s %3d %4.1f%%", bar, val, pct)
    end

    puts row
  end
end

# Collect file data across Models, Controllers, and Views
categories = {
  "models"      => { file_count: 0, counts: [] },
  "controllers" => { file_count: 0, counts: [] },
  "views"       => { file_count: 0, counts: [] }
}

categories["models"][:file_count], categories["models"][:counts] = process_directory("app/models/**/*.rb")
categories["controllers"][:file_count], categories["controllers"][:counts] = process_directory("app/controllers/**/*.rb")
categories["views"][:file_count], categories["views"][:counts] = process_directory("app/views/**/*.{html.erb,erb,slim,haml}")

render_chart(categories)