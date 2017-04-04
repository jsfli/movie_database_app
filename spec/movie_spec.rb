require("spec_helper")

describe(Movie) do

  before () do
    @test_movie = Movie.new({:name=> "Ocean Eleven", :id => nil})
    @test_movie2 = Movie.new({:name=> "Ocean Twelve", :id => nil})
  end

  describe("#initialize") do
    it("is initialized with a name") do
      expect(@test_movie.name()).to(eq("Ocean Eleven"))
    end

    it("is initialized with an id") do
      expect(@test_movie.id()).to(eq(nil))
    end
  end

  describe(".all") do
    it("starts off with no movies") do
      expect(Movie.all()).to(eq([]))
    end
  end

  describe("#==") do
    it("is the same movie if it has the same name and id") do
      test_movie3 = Movie.new({:name=> "Ocean Eleven", :id => nil})
      expect(@test_movie).to(eq(test_movie3))
    end
  end

  describe("#save") do
    it("saves a movie to a the movies database") do
      @test_movie.save()
      expect(Movie.all()).to(eq([@test_movie]))
    end
  end

  describe(".find") do
    it("returns a movie by its ID number") do
      @test_movie.save()
      @test_movie2.save()
      expect(Movie.find(@test_movie.id())).to(eq(@test_movie))
    end
  end

  describe("#update") do
    it("lets you update movies in the database") do
      @test_movie.save()
      @test_movie.update({:name => "Oceans Twelve"})
      expect(@test_movie.name()).to(eq("Oceans Twelve"))
    end

    it("lets you add an actor to a movie") do
      @test_movie.save()
      george = Actor.new({:name => "George Clooney", :id=>nil})
      george.save()
      brad = Actor.new({:name => "Brad Pitt", :id=>nil})
      brad.save()
      @test_movie.update({:actor_ids => [george.id(), brad.id()]})
      expect(@test_movie.actors()).to(eq([george, brad]))
    end
  end

  describe("#actors") do
    it("returns all of the actors in a particular movie") do
      @test_movie.save()
      george = Actor.new({:name => "George Clooney", :id=>nil})
      george.save()
      brad = Actor.new({:name => "Brad Pitt", :id=>nil})
      brad.save()
      @test_movie.update({:actor_ids => [george.id(), brad.id()]})
      expect(@test_movie.actors()).to(eq([george, brad]))
    end
  end

  describe("#delete") do
    it("let you delete an actor from the database") do
      @test_movie.save()
      @test_movie2.save()
      @test_movie.delete()
      expect(Movie.all()).to(eq([@test_movie2]))
    end
  end

end
