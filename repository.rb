require_relative  'report'
require 'csv'
class Repository
  def initialize(csv_file_path)
    @counter = 1;
    @reports = [] # <=  storing  reports in memory array of reciple objects
    # declare new variable
    @csv_file_path = csv_file_path
    @csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

    # load
  end

#   def load # loads csv contents into @report object array
#     CSV.foreach(@csv_file_path, @csv_options) do |row|
#       @reports << Report.new(row[0], row[1])
#     end
#     return @reports
#   end

  def save
    # upload each 2 dimension array to csv file
    CSV.open(@csv_file_path, 'wb') do |csv|
        csv << ["id","location","Rating"]
        @reports.each { |item| csv << [item.id, item.location, item.rating] }
    end
  end

  def all
    # turns repo into an indexed list
    result = []
    @reports.each_with_index do |report, i|
        result << "[#{i}] #{report.location} #{report.rating}"
    end
    result
  end

  def add_report(report)
    # assign id
    report.id = @counter;
    @counter += 1
    # add report to end of array
    @reports << report
    save
  end

  def remove_report(report_index)
    # delete item in array at given index
    @reports.delete_at(report_index.to_i)
    save
  end
end


first = Report.new(attributes = { location: "Port Goret", rating_am: [0,0,0,0]})
repo = Repository.new("surf-data-csv.csv")
repo.add_report(first)
repo.save
second = Report.new(attributes = { location: "Treveneuc", rating: [0,2,1,1] })
repo.add_report(second)
repo.save