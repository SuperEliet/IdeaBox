class Idea
	require 'yaml/store'
	attr_reader :title, :description

  def self.delete(position)
    database.transaction do
      database['ideas'].delete_at(position)
    end
  end

  def initialize(title, description)
    @title = title
    @description = description
  end

  def save
    database.transaction do |db|
      db['ideas'] ||= []
      db['ideas'] << {title: title, description: description}
    end
  end

  def self.all
    raw_ideas.map do |data|
      Idea.new(data[:title], data[:description])
    end
  end

  def self.raw_ideas
    database.transaction do |db|
      db['ideas']
    end || []
  end

  def self.database
    @database ||= YAML::Store.new('ideabox')
  end

  def database
    Idea.database
  end
end