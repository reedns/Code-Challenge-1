class Library
  attr_reader :shelves, :unshelved_books

  def initialize
    @shelves = []
    @unshelved_books = []
  end

  def count_shelves
    if shelves.size >= 2
      puts "The library has #{shelves.size} shelves"
    elsif shelves.size == 1
      puts "The library has 1 shelf"
    else
      puts "The library has no shelves"
    end 
  end

  def report_library_books
    books_in_library = shelves.map(&:books_on_shelf)
    puts "The library has these books: "
    books_in_library.each do |shelf|
      shelf.each { |book| puts "- #{book.title} by #{book.author}" }
    end
    unshelved_books.each { |book| puts "- #{book.title} by #{book.author} [unshelved]" }
  end

 
end

class Shelf
  attr_reader :genre, :books_on_shelf

  def initialize(library, genre)
    library.shelves << self
    @genre = genre
    @books_on_shelf = []
  end

  def list_books
    puts "Books under #{genre}:"
    books_on_shelf.each { |book| puts "- #{book.title} by #{book.author}" }
    puts "No books under #{genre}" if books_on_shelf == []
  end
end

class Book
  attr_reader :title, :author
  
  def initialize(title, author)
    @title = title
    @author = author
  end

  def enshelf(shelf=[])
    shelf.books_on_shelf << self
  end

  def unshelf(shelf=[], library)
    shelf.books_on_shelf.delete(self)
    library.unshelved_books << self
  end
end

public_library = Library.new
public_library.count_shelves

literature = Shelf.new(public_library, "Literature")
public_library.count_shelves
literature.list_books

moby_dick = Book.new("Moby Dick", "Herman Melville")
solitude = Book.new("100 Years of Solitude", "Gabriel Garcia Marquez")

moby_dick.enshelf(literature)
solitude.enshelf(literature)

literature.list_books
moby_dick.unshelf(literature, public_library)
literature.list_books

history = Shelf.new(public_library, "History")
public_library.count_shelves

people_history = Book.new("People's History of the United States", "Howard Zinn")
people_history.enshelf(history)

public_library.report_library_books

