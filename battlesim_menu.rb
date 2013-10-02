class BattleSimMenu < Chingu::GameState
    def setup
        self.input={ :enter => :select,
                     :up_arrow => :up,
                     :down_arrow => :down
        }

        @width = $window.width
        @height = $window.height
        @new = Text.create("New Game", :size => 40, :x => 0, :y => @height/5, :color => Gosu::Color::BLACK, :align => :center, :max_width => @width)
        @load = Text.create("Load", :size => 40, :x => 0, :y => 2*@height/5, :color => Gosu::Color::BLACK, :align => :center, :max_width => @width)
        @settings = Text.create("Settings", :size => 40, :x => 0, :y => 3*@height/5, :color => Gosu::Color::BLACK, :align => :center, :max_width => @width)
        @quit = Text.create("Quit", :size => 40, :x => 0, :y => 4*@height/5, :color => Gosu::Color::BLACK, :align => :center, :max_width => @width)

        @selected = 0
    end

    def up
        @selected = (@selected - 1) % 4
        draw
    end

    def down
        @selected = (@selected + 1) % 4
        draw
    end

    def select
    end

    def draw 
        super
        draw_rect(Rect::new([2*@width/5,(((@selected+1)*@height)/5)+30,@width/5,1]), Color::BLACK, 1)
    end

end
