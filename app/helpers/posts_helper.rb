module PostsHelper

    def postSortSelection(url, id, sort)
        if url === "http://localhost:3000/new" && id === "new"
            "override"
        elsif url === "http://localhost:3000/" && id === "front_page" && sort === "front_page" 
            "override"
        elsif url === "http://localhost:3000/top" && id === "top" && sort === "top"
            "override"
        elsif url === "http://localhost:3000/" && id === "top" && sort === "top"
            "override"
        end
    end

    def profile?(controller)
        if controller == "posts"
            "px-3"
        end
    end

end
