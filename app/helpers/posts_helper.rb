module PostsHelper

    def postSortSelection(url, id, sort)
        if url === "https://reddit-clone-rails.herokuapp.com/new" && id === "new"
            "override"
        elsif url === "https://reddit-clone-rails.herokuapp.com/" && id === "front_page" && sort === "front_page" 
            "override"
        elsif url === "https://reddit-clone-rails.herokuapp.com/top" && id === "top" && sort === "top"
            "override"
        elsif url === "https://reddit-clone-rails.herokuapp.com/" && id === "top" && sort === "top"
            "override"
        end
    end

    def profile?(controller)
        if controller == "posts"
            "px-3"
        end
    end

end
