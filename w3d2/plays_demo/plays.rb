require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def self.find_by_title(title)
    Play.all.select do |play|
      play.title == title
    end.first
  end

  def self.find_by_playwright(name)
    playwright = Playwright.find_by_name(name)
    plays = PlayDBConnection.instance.execute(<<-SQL, playwright.id)
       SELECT
         *
       FROM
         plays
       WHERE
         playwright_id = ?
     SQL
     plays.map { |play| Play.new(play) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end

end

class Playwright
  attr_accessor :name, :id

  def initialize(options)
    @name = options['name']
    @id = options['id']
  end

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    data.map { |datum| Playwright.new(datum) }
  end

  def self.find_by_name(name)
    Playwright.all.select do |playwright|
      playwright.name == name
    end.first
  end

  def create
    raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @name, @id)
      INSERT INTO
        playwrights(name, id)
      VALUES
        (?, ?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @name, @id)
      UPDATE
        playwrights
      SET
        name = ?
      WHERE
        id = ?
    SQL
  end

  def get_plays
    Plays.all.select do |play|
      play.playwright_id == @id
    end
  end

end
