class Client
  include ActiveModel::Model

  attr_accessor :client
  def initialize
    @client = Savon.client(
      wsdl:  ENV["URL"],
      basic_auth: [ENV["NUSER_NAME"], ENV["N_PASSWORD"]],
      open_timeout: 1000,
      read_timeout: 1000,
      logger: Rails.logger,
      log: true,
      #log_level: debug,
      follow_redirects: :follow_redirects,
      pretty_print_xml: true
    )
  end

end
