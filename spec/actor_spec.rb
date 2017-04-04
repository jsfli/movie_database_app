require("spec_helper")

describe(Actor) do

  before() do
    @test_actor = Actor.new({:name => "Brad Pitt", :id=> nil})
  end

  describe("#initialize") do
    it("is initialized with a name") do
      expect(@test_actor.name()).to(eq("Brad Pitt"))
      expect(@test_actor.id()).to(eq(nil))
    end
  end

  describe(".all") do
    it("starts off with no movies") do
      expect(Actor.all()).to(eq([]))
    end
  end

  describe("#==") do
    it("is the same actor if it has the same name and id") do
      test_actor2 = Actor.new({:name => "Brad Pitt", :id => nil})
      expect(@test_actor).to(eq(test_actor2))
    end
  end

  describe("#save") do
    it("saves an actor entry to the database")do
    @test_actor.save()
    expect(Actor.all()).to(eq([@test_actor]))
    end
  end

  describe(".find") do
    it("returns an actor by its ID number") do
      @test_actor.save()
      test_actor2 = Actor.new({:name => "George Clooney", :id => nil})
      test_actor2.save()
      expect(Actor.find(test_actor2.id())).to(eq(test_actor2))
    end
  end

  describe("#update") do
    it("lets you update actors in the database") do
      @test_actor.save()
      @test_actor.update({:name => "Brad Pitt"})
      expect(@test_actor.name()).to(eq("Brad Pitt"))
    end

    it("lets you add a movie to an actor") do
      movie = Movie.new({:name => "Oceans Eleven", :id => nil})
      movie.save()
      @test_actor.save()
      @test_actor.update({:movie_ids => [movie.id()]})
      expect(@test_actor.movies()).to(eq([movie]))
    end
  end

  describe("#delete") do
    it("lets you delete an actor from the database") do
      @test_actor.save()
      test_actor2 = Actor.new({:name => "George Clooney", :id => nil})
      test_actor2.save()
      @test_actor.delete()
      expect(Actor.all()).to(eq([test_actor2]))
    end
  end

  describe("#movies") do
    it("returns all of the movies a particular actor has been in") do
      movie = Movie.new(:name => "Oceans Eleven", :id => nil)
      movie.save()
      movie2 = Movie.new(:name => "Oceans Twelve", :id => nil)
      movie2.save()
      @test_actor.save()
      @test_actor.update({:movie_ids => [movie.id(),movie2.id()]})
      expect(@test_actor.movies()).to(eq([movie, movie2]))
    end
  end

end
