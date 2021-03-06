class Book
    attr_accessor :title, :id
    def initialize(attributes)
        @title = attributes[:title]
        @id = attributes[:id].to_i
    end
    def save
        @id = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;").first.fetch("id").to_i
        self
    end
    def update(new_attrs)
        @title = new_attrs[:title]
        DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{@id};")
    end
    def delete
        DB.exec("DELETE FROM books WHERE id = #{@id};")
        DB.exec("DELETE FROM authors WHERE book_id = #{@id};")
    end
    def authors
      Author.find_by_book(@id)
    end
    def ==(compare)
        (@title == compare.title)
    end

    #class methods
    def self.all
        DB.exec("SELECT * FROM books;").map { |book| Book.new(self.keys_to_sym(book)) }
    end
    def self.clear
        DB.exec("DELETE FROM books *;")
    end
    def self.find(search_id)
        attributes = DB.exec("SELECT * FROM books WHERE id = #{search_id};").first
        Book.new(self.keys_to_sym(attributes))
    end

    private
    def self.keys_to_sym(str_hash)
        str_hash.reduce({}) do |acc, (key, val)|
            acc[key.to_sym] = (['id'].include? key) ? val.to_i : val
            acc
        end
    end
end
