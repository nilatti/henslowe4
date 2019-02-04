class BulkImport
  def initialize
    @sources = Dir.entries('external_data/sources')
  end

  def run
    @sources.each do |source|
      if source.length > 2 && source.match(/\.xml/)
        ImportFromFolgerXml.new("external_data/sources/#{source}").run
      end
    end
  end
end
