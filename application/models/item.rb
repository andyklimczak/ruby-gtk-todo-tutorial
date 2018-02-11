require 'securerandom'
require 'json'

module Todo
  class Item
    PROPERTIES = [:id, :title, :notes, :priority, :filename, :create_datetime].freeze
    PRIORITIES = ['high', 'medium', 'normal', 'low'].freeze

    attr_accessor *PROPERTIES

    def initialize(options = {})
      if user_data_path = options[:user_data_path]
        @id = SecureRandom.uuid
        @creation_datetime = Time.now.to_s
        @filename = "#{user_data_path}/#{id}.json"
      elsif filename = options[:filename]
        load_from_file filename
      else
        raise ArgumentError, 'Please specifiy the :user_data_path for new items or :filename to load existing'
      end
    end

    def load_from_file(filename)
      properties = JSON.parse(File.read(filename))

      PROPERTIES.each do |property|
        self.send "#{property}=", properties[property.to_s]
      end
    rescue => e
      raise ArgumentError, "Failed to load existing item: #{e.message}"
    end

    def is_new?
      !File.exists? @filename
    end

    def save!
      File.open(@filename, 'w') do |file|
        file.write self.to_json
      end
    end

    def delete!
      raise 'Item is not saved' if is_new?

      File.delete(@filename)
    end

    def to_json
      result = {}
      PROPERTIES.each do |prop|
        result[prop] = self.send prop
      end
      result.to_json
    end
  end
end
