class ApplicationController < ActionController::Base
    layout :set_layout

    class Forbidden < ActionController::ActionControllerError; end
    class IpAddressRejected < ActionController::ActionControllerError; end

    rescue_from StandardEroor, with: :rescue500
    rescue_from Forbidden, with: :rescue 403
    rescue_from IpAddressRejected, with: :rescue403

    private def set_layout
        if params[:controller].match(%r{\A(staff|admin|customer)/})
            Regexp.last_match[1]
        else
            "customer"
        end
    end

    private def rescue403(e)
        @exception = e
        render "errors/forbidden", status: 403
    end

    private def rescue500(e)
        render "error/internal_server_error", status: 500
    end
end
