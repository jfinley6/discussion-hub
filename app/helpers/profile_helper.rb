module ProfileHelper

    def changeKarmaColor karma
        if karma > 0
            "green"
        elsif karma < 0
            "red"
        else
            "black"
        end
    end

end
