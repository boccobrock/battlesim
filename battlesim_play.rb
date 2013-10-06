$LOAD_PATH.unshift File.join(File.expand_path(__FILE__), "..", "..", "lib")

class BattleSimPlay < Chingu::GameState
    def setup
        self.input={ :esc => :menu,
                     :m => :create
        }

        @ships = Array.new
    end

    def create
        @ships.push HumanShip.create(:x => rand($window.width), :y => rand($window.height))
    end

    def menu
        pop_game_state(:setup => false, :finalize => false)
    end

    def draw 
        super
    end

end

class HumanShip < Chingu::GameObject
    traits :velocity, :collision_detection

    def initialize(options)
        super
        @image = Image["hship.png"]
        @xtarget = self.x
        @ytarget = self.y
        self.velocity_x = 0
        self.velocity_y = 0 

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

    def update
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
        puts self.angle
    end
end
