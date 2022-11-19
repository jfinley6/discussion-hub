module PostsHelper

    def postSortSelection(url, id)
        if url === "http://localhost:3000/new" && id === "new"
            "override"
        elsif url === "http://localhost:3000/" && id === "top" 
            "override"
        elsif url === "http://localhost:3000/front_page" && id === "front_page" 
            "override"
        end
    end

end
