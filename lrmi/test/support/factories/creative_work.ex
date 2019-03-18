defmodule Lrmi.CreativeWorkFactory do
  defmacro __using__(_opts) do
    quote do
      def creative_work_factory do
        %{
          typeOf: "Book",
          name: sequence("My content about mathematic, elementary year 1"),
          dateCreated: "2018-03-24T15:30:00Z",
          dateModified: "2018-04-01T09:10:00Z",
          author: [
            %{
               typeOf: "Person",
               name: "Johon Smith",
               url: "http://my-user-host.test.com/user/122"
            }
          ],
          additionalProperty: [
            %{
              typeOf: "PropertyValue",
              propertyID: "Collection-Name",
              value: "MyCollection"
            }
          ],
          identifier: %{
            typeOf: "PropertyValue",
            propertyID: "ContentHost-ContentID",
            value: sequence("112121")
          },
          publisher: %{
            typeOf: "Organization",
            name: "MyPublisher"
          },
          inLanguage: %{
            typeOf: "Language",
            name: "Portuguese",
            alternateName: "pt-br"
          },
          educationalUse: "Professional Support",
          interactivityType: "Expositive",
          learningResourceType: "Didactic Material",
          educationalAlignment: [
            %{
              typeOf: "AlignmentObject",
              alignmentType: "educationLevel",
              educationalFramework: "Diretrizes e Bases da Educação Nacional (LDB)",
              targetName: "Elementary school 1",
              targetURL: "http://portal.mec.gov.br/secretaria-de-educacao-basica"
            },
            %{
              typeOf: "AlignmentObject",
              alignmentType: "educationalSubject",
              educationalFramework: "Diretrizes e Bases da Educação Nacional (LDB)",
              targetName: "Mathematic",
              targetURL: "http://portal.mec.gov.br/secretaria-de-educacao-basica"
            },
          ],
          url: "http://my-content-host.test.com/content/112121"
        }
      end
    end
  end
end
