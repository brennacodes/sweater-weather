**Final Assessment**

1. Create a branch off of your Sweater Weather project called “final”
2. As you work, you should commit to this branch **every 15 minutes**.
3. DO NOT push your code to your GitHub repo until the end of the 3 hour assessment, unless otherwise directed by instructors
4. Complete the user story below. You should:
- TDD all of your work
- Prioritize getting your code functional before attempting any refactors
- Write/refactor your code to achieve good code quality

5. Turn in your assessment [here](https://forms.gle/kMQc4H1DhS6i9QPh9).**Assignment**You will be using the “[Open Library API](https://openlibrary.org/developers/api)” to search for books based on a destination city provided by the user. Presume that your user will give a known “good” location. (you can handle edge cases later). **You will not need an API key to access this API**Your endpoint should follow this format:`GET /api/v1/book-search?location=denver,co&quantity=5`

- please do not deviate from the names of the endpoint or query parameter, be sure it is called “book-search” and “location” and “quantity”, respectively
- quantity should be a positive integer greater than 0

Your API will return:

- the destination city
- the forecast in that city right now
- the total number of search results found
- a quantity of books about the destination city

Your response should be in the format below:

```
{
  "data": {
    "id": "null",
    "type": "books",
    "attributes": {
      "destination": "denver,co",
      "forecast": {
        "summary": "Cloudy with a chance of meatballs",
        "temperature": "83 F"
      },
      "total_books_found": 172,
      "books": [
        {
          "isbn": [
            "0762507845",
            "9780762507849"
          ],
          "title": "Denver, Co",
          "publisher": [
            "Universal Map Enterprises"
          ]
        },
        {
          "isbn": [
            "9780883183663",
            "0883183668"
          ],
          "title": "Photovoltaic safety, Denver, CO, 1988",
          "publisher": [
            "American Institute of Physics"
          ]
        },
        { ... same format for books 3, 4 and 5 ... }
      ]
    }
  }
}
```

(edited)

[https://slack-imgs.com/?c=1&o1=wi32.he32.si&url=https%3A%2F%2Fopenlibrary.org%2Ffavicon.ico](https://slack-imgs.com/?c=1&o1=wi32.he32.si&url=https%3A%2F%2Fopenlibrary.org%2Ffavicon.ico)

**openlibrary.org**

**[Developer Center / APIs | Open Library](https://openlibrary.org/developers/api)**

Open Library is an open, editable library catalog, building towards a web page for every book ever published. Read, borrow, and discover more than 3M books for free.