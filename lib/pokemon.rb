class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize(id:, name:, type:, db:)
        @id = id 
        @name = name
        @type = type 
        @db = db
    end 

    def self.save(name, type, db)
        sql = <<-SQL
          INSERT INTO pokemon (name, type) values (?,?);
        SQL
        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        sql = <<-SQL
          SELECT * FROM pokemon WHERE id=#{id};
        SQL
        db.execute(sql).map { |row|
          pokemon = self.new(name: row[1], type: row[2], db: db,id:id)
          pokemon
        }.first
    end
    
end
