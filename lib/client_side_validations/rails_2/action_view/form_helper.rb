module ClientSideValidations::Rails2::ActionView::Helpers
  module FormHelper
    def form_for(record_or_name_or_array, *args, &proc)
      html = super
      if html.match(/<script data-csv.+<\/script>$/)
        splitted = html.split('<script data-csv')
        concat('<script data-csv'+splitted.last)
      end
    end
  end
end

