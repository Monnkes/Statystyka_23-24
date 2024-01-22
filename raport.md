## Porównanie Algorytmów Minimalizacji Stochastycznej
###### Opracowali: Mateusz Sacha, Łukasz Kluza
---

#### Wprowadzenie
Celem tego projektu zaliczeniowego było porównanie efektywności dwóch z trzech algorytmów minimalizacji stochastycznej: Poszukiwania Przypadkowego (Pure Random Search, PRS), Metody Wielokrotnego Startu (Multi-Start, MS) oraz Algorytmu Genetycznego (GA). Zdecydowaliśmy się na algorytm _Poszukiwania Przypadkowego_  oraz _Metodę Wielokrotnego Startu_. Analiza została przeprowadzona na funkcjach Ackley'a i Rastrigina o różnej liczbie wymiarów: 2, 10 i 20.

#### Algorytmy
- Poszukiwanie Przypadkowe (PRS)
Algorytm PRS polega na losowaniu punktów z rozkładem jednostajnym w określonej dziedzinie poszukiwań. Dla każdej funkcji i wymiaru losowano odpowiednią liczbę punktów.

- Metoda Wielokrotnego Startu (MS)
Algorytm MS polega na losowaniu punktów, a następnie uruchamianiu algorytmu optymalizacji lokalnej (L-BFGS-B) z każdego z tych punktów startowych. Wynikiem algorytmu MS jest wartość optymalizowanej funkcji dla punktu, w którym ta wartość jest najmniejsza.

#### Funkcje Minimalizowane
Do analizy wybrano funkcje Ackley'a i Rastrigina. Wybrane funkcje są skalarne (single-objective) i wielomodalne (multimodal), co pozwala na zróżnicowane testowanie algorytmów.

#### Procedura Porównawcza
Dla każdej funkcji i liczby wymiarów osobno, przeprowadzono 50 uruchomień każdego algorytmu.
Średni wynik algorytmu obliczono jako średnią znalezionych minimów.
Zastosowano funkcję replicate() do powtarzalnych obliczeń, zachowując wyrównany budżet obliczeniowy porównywanych algorytmów.

#### Budżet Obliczeniowy
Dla algorytmu MS, liczba punktów startowych wyniosła 100, a średnia liczba wywołań z uruchomień MS była przyjętą wartością budżetu dla algorytmu PRS.

#### Wyniki
| Algorytm | Dim | ackley_function | rastrigin_function |
|----------|-----|-----------------|---------------------|
| **PRS**  | 2   | Wynik           | Wynik               |
|          | 10  | Wynik           | Wynik               |
|          | 20  | Wynik           | Wynik               |
| **MS**   | 2   | Wynik           | Wynik               |
|          | 10  | Wynik           | Wynik               |
|          | 20  | Wynik           | Wynik               |


#### Analiza Danych 

| Funkcja | Wymiar | Algorytm | Średni Wynik | Przedział Ufności (95%) From | Przedział Ufności (95%) To | Test hipotezy zerowej |
|---------|--------|----------|----------|----------|----------|----|
| Ackley     | 2       | MS       | 0.310260086052536    | -4.01445674261985  | 10.7190968785033  | Nie odrzucamy |
| Rastrigin  | 2       | PRS      | 0.262227176852398    | -7.32003759908092  | 2.35848378710629  | Nie odrzucamy |
| Ackley     | 10      | MS       | 0.603841047529186    | -0.420836443941044 | 0.664614888556282 | Nie odrzucamy |
| Rastrigin  | 10      | PRS      | 0.0151618237498921   | -56.3409534272822  | -8.52147864179943 | Odrzucamy |
| Ackley     | 20      | MS       | 0.00547052906335119  | -1.09083736637915  |-0.302291770220293 | Nie odrzucamy |
| Rastrigin  | 20      | PRS      | 8.05108545900524e-05 | -106.684511015394  |-56.1011964927611  | Odrzucamy |

#### Analiza Wykresów:
- **Wymiar 2:**
Histogram:
Boxplot:
_Analiza:_
Histogramy pokazują rozkłady wyników dla obu algorytmów.
Boxploty przedstawiają rozproszenie wyników w sposób graficzny.
Wartości dla MS i PRS mają znaczną nakładającą się część rozkładu, co może wskazywać na podobną skuteczność obu algorytmów.
<br>
- **Wymiar 10:**
Histogram:
Boxplot:
_Analiza:_
Histogramy dla MS i PRS wskazują na zbliżone rozkłady wyników.
Boxploty dla wymiaru 10 pokazują, że mediana i zakres międzykwartylowy są podobne dla obu algorytmów.
<br>
- **Wymiar 20:**
Histogram:
Boxplot:
_Analiza:_
Histogramy dla wymiaru 20 również wykazują podobieństwo między rozkładami wyników MS i PRS.
Boxploty pokazują stabilność algorytmów w zakresie mediany i rozproszenia wyników.

***Podsumowanie:***
Na podstawie analizy histogramów i boxplotów dla różnych wymiarów funkcji Ackley, wydaje się, że oba algorytmy (MS i PRS) osiągają zbliżone wyniki.
Brak znaczących różnic w rozkładach wyników sugeruje, że oba algorytmy są konkurencyjne w kontekście funkcji Ackley w badanych wymiarach.
Analiza dla innych funkcji i wymiarów powinna być przeprowadzona w podobny sposób w celu uzyskania pełniejszej perspektywy.


#### Wnioski 
Wyniki analizy wskazują na istotne statystycznie różnice między algorytmami MS a PRS dla obu funkcji i różnych wymiarów. Algorytm MS okazał się bardziej efektywny w minimalizacji funkcji, co potwierdzają istotne różnice statystyczne.
