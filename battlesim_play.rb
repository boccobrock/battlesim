$LOAD_PATH.unshift File.join(File.expand_path(__FILE__), "..", "..", "lib")

class BattleSimPlay < Chingu::GameState
    def setup
        self.input={ :esc => :menu
        }

        @width = $window.width
        @height = $window.height
        HumanShip.create(:x => rand($window.width), :y => rand($window.height))
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
        self.velocity_x = 0
        self.velocity_y = -1 
    end

    def update
    end
end
