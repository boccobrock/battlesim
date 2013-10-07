$LOAD_PATH.unshift File.join(File.expand_path(__FILE__), "..", "..", "lib")

class BattleSimPlay < Chingu::GameState
    def setup
        self.input={ :esc => :menu,
                     :n => :next_level
        }

        @level = 0
        @ships = Array.new
        make_level
    end

    def next_level
        @level = @level + 1
    end

    def make_level
        enemies = LEVELS[@level][:enemies]
        enemies.times do |count|
            location = ((count * $window.width) / (enemies+1)) + 20
            create_ship(location, 30, false)
        end

        allies = LEVELS[@level][:allies]
        allies.times do |count|
            location = ((count * $window.width) / (allies+1)) + 20
            create_ship(location, $window.height-30, true)
        end
    end

    def create_ship(x, y, ally)
        @ships.push HumanShip.create(:x => x, :y => y, :ally => ally)
    end

    def menu
        pop_game_state(:setup => false, :finalize => false)
    end

    def update
        super
        HumanShip.each_collision(HumanShip) do |ship1, ship2|
            ship1.stop
            ship2.stop
            ship1.shoot!
            ship2.shoot!
        end
    end

    def draw 
        super
    end

end

class HumanShip < Chingu::GameObject
    traits :velocity, :collision_detection, :bounding_circle
    attr_accessor :ally

    def initialize(options)
        super
        @image = Image["hship.png"]
        @xtarget = self.x
        @ytarget = self.y
        self.velocity_x = 0
        self.velocity_y = 0 

        self.ally = options[:ally]

        if self.ally
            self.input={ :w => :topleft,
                         :e => :top,
                         :r => :topright,
                         :s => :left,
                         :d => :center,
                         :f => :right,
                         :x => :bottomleft,
                         :c => :bottom,
                         :v => :bottomright
            }
        else
            self.angle = 180
        end

        cache_bounding_circle
    end

    def shoot!
        @color = Color::RED
    end

    def topleft
        @xtarget = 0
        @ytarget = 0
    end

    def top
        @xtarget = $window.width/2
        @ytarget = 0
    end

    def topright
        @xtarget = $window.width
        @ytarget = 0
    end

    def left
        @xtarget = 0
        @ytarget = $window.height/2
    end

    def center
        @xtarget = $window.width/2
        @ytarget = $window.height/2
    end

    def right
        @xtarget = $window.width
        @ytarget = $window.height/2
    end

    def bottomleft
        @xtarget = 0
        @ytarget = $window.height
    end

    def bottom
        @xtarget = $window.width/2
        @ytarget = $window.height
    end

    def bottomright
        @xtarget = $window.width
        @ytarget = $window.height
    end

    def stop
        @xtarget = self.x
        @ytarget = self.y
    end

    def update
        super 

        xdiff = @xtarget-self.x
        ydiff = @ytarget-self.y
        total = 0.0 + xdiff.abs + ydiff.abs

        if total != 0
            self.velocity_y = ydiff / total
            self.velocity_x = xdiff / total
        else
            self.velocity_y = 0
            self.velocity_x = 0
        end

        if xdiff != 0
            if xdiff < 0
                self.angle = 270 - (Math.atan(-1*ydiff/xdiff) * (180 / Math::PI))
            else
                self.angle = 90 - (Math.atan(-1*ydiff/xdiff) * (180 / Math::PI))
            end
        end
    end
end

LEVELS = Hash.new
LEVELS[0] = {enemies: 10, allies: 1}
