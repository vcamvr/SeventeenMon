module SeventeenMon
  class IPDB
    attr_reader :offset, :index, :max_comp_length

    private_class_method :new

    def initialize
      @ip_db_path = File.expand_path('../../data/17monipdb.dat', __FILE__)
      File.open @ip_db_path, 'rb' do |ip_db|
        @offset = ip_db.read(4).unpack("Nlen")[0]
        @index = ip_db.read(offset - 4)
        @max_comp_length = @offset - 1028
      end
    end

    def self.instance
      @instance ||= self.send :new
    end

    def seek(_offset, length)
      IO.read(@ip_db_path, length, offset + _offset - 1024).split "\t"
    end
  end
end
