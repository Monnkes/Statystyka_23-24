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
| **PRS**  | 2   | 9.50265         |7.258155             |
|          | 10  | 18.98935        | 98.018893           |
|          | 20  | 19.99352        | 234.176595          |
| **MS**   | 2   | 2.093723        | 0.4178828           |
|          | 10  | 17.946352       | 31.2416235          |
|          | 20  |18.672037        | 92.0134158          |


#### Wykresy

<p align="center">
  <img src="plots/HISTOGRAM_MS_n100_2.png" alt="HISTOGRAM_MS_n100_2">
</p>

<p align="center">
  <img src="plots/HISTOGRAM_MS_n100_10.png" alt="HISTOGRAM_MS_n100_10">
</p>

<p align="center">
  <img src="plots/HISTOGRAM_MS_n100_20.png" alt="HISTOGRAM_MS_n100_20">
</p>

<p align="center">
  <img src="plots/HISTOGRAM_PRS_n100_2.png" alt="HISTOGRAM_PRS_n100_2">
</p>

<p align="center">
  <img src="plots/HISTOGRAM_PRS_n100_10.png" alt="HISTOGRAM_PRS_n100_10">
</p>
<p align="center">
  <img src="plots/HISTOGRAM_PRS_n100_20.png" alt="HISTOGRAM_PRS_n100_20">
</p>
<p align="center">
  <img src="plots/BOXPLOT_n100.png" alt="BOXPLOT_n100">
</p>

<p align="center">
  <img src="plots/POINTPLOT_n100.png" alt="POINTPLOT_n100">
</p>




#### Analiza Danych 

| Funkcja | Wymiar | Algorytm | Średni Wynik | Przedział Ufności (95%) (Od) | Przedział Ufności (95%) (Do) | Test hipotezy zerowej |
|---------|--------|----------|----------|----------|----------|----|
| Ackley     | 2  | MS  | 3.47001968819578e-22 | -8.57198813879057  | -6.24586491250253  | Odrzuamy |
| Rastrigin  | 2  | PRS | 8.55373939846609e-19 | -7.84133241450304  | -5.83921125848375  | Odrzuamy |
| Ackley     | 10 | MS  | 3.1928688588889e-15  | -1.26415460269664  | -0.821839055716593 | Odrzuamy |
| Rastrigin  | 10 | PRS | 1.36019908007974e-52 | -70.5366461565981  | -63.0178932607597  | Odrzuamy |
| Ackley     | 20 | MS  | 1.38872501800785e-40 | -1.43585391351074  | -1.20710453980896  | Odrzuamy |
| Rastrigin  | 20 | PRS | 1.48057245516509e-66 | -148.361908348892  | -135.964449187906  | Odrzuamy |

Analiza danych przedstawionych w tabeli obejmuje wyniki eksperymentu porównawczego pomiędzy algorytmami Poszukiwania Przypadkowego (PRS) a Metodą Wielokrotnego Startu (MS) na funkcjach Ackley'a i Rastrigina, w różnych wymiarach.

__Wyniki dla funkcji Ackley:__

_Wymiar 2:_
Algorytm MS osiągnął średni wynik bliski zeru, co sugeruje skuteczność w minimalizacji funkcji Ackley w dwóch wymiarach.
Przedział ufności nie zawiera zera, co może sugerować statystyczną istotność wyników.

_Wymiar 10:_
Algorytm MS również osiągnął bliski zeru średni wynik, co wskazuje na skuteczność w wyższych wymiarach.
Ponownie przedział ufności jest istotny statystycznie.

_Wymiar 20:_
Algorytm MS utrzymuje skuteczność nawet w 20 wymiarach, co potwierdza jego zdolność do radzenia sobie z większą liczbą wymiarów.
Przedział ufności jest również statystycznie istotny.

__Wyniki dla funkcji Rastrigina:__
_Wymiar 2:_
Algorytm PRS uzyskał lepsze wyniki w minimalizacji funkcji Rastrigina niż algorytm MS.
Przedział ufności jest statystycznie istotny, co potwierdza różnicę między wynikami algorytmów.

_Wymiar 10:_
Algorytm PRS nadal osiąga lepsze wyniki, ale różnica nie jest już tak znacząca jak w przypadku dwóch wymiarów.
Przedział ufności pozostaje jednak statystycznie istotny.

_Wymiar 20:_

Również dla 20 wymiarów algorytm PRS osiąga lepsze wyniki niż MS.
Przedział ufności potwierdza statystyczną istotność wyników.

#### Analiza Wykresów:
- **Wymiar 2:**

_Analiza:_
Histogramy pokazują rozkłady wyników dla obu algorytmów.
Boxploty przedstawiają rozproszenie wyników w sposób graficzny.
Wartości dla MS i PRS mają znaczną nakładającą się część rozkładu, co może wskazywać na podobną skuteczność obu algorytmów.
<br>
- **Wymiar 10:**

_Analiza:_
Histogramy dla MS i PRS wskazują na zbliżone rozkłady wyników.
Boxploty dla wymiaru 10 pokazują, że mediana i zakres międzykwartylowy są podobne dla obu algorytmów.
<br>
- **Wymiar 20:**

_Analiza:_
Histogramy dla wymiaru 20 również wykazują podobieństwo między rozkładami wyników MS i PRS.

Test hipotezy zerowej można przeprowadzić, aby ocenić, czy istnieją statystycznie istotne różnice między wynikami algorytmów PRS i MS dla każdej funkcji i wymiaru. W tym kontekście, możemy sformułować hipotezę zerową (H0) i hipotezę alternatywną (H1):

Hipoteza zerowa (H0): Nie ma istotnej różnicy między wynikami algorytmów PRS i MS.
Hipoteza alternatywna (H1): Istnieje istotna różnica między wynikami algorytmów PRS i MS.
Możemy użyć testu t-studenta dla dwóch niezależnych prób, aby porównać średnie wyniki algorytmów. Wartości p-wartości poniżej pewnego poziomu istotności (na przykład 0.05) sugerują odrzucenie hipotezy zerowej.

**Test hipotez zerowych**

Przeprowadźmy testy hipotez dla kilku przypadków:

_Wymiar 2 dla funkcji Ackley:_
H0: Średnie wyniki PRS i MS są równe.
H1: Średnie wyniki PRS i MS są różne.

_Wymiar 10 dla funkcji Rastrigina:_
H0: Średnie wyniki PRS i MS są równe.
H1: Średnie wyniki PRS i MS są różne.

_Wymiar 20 dla funkcji Ackley:_
H0: Średnie wyniki PRS i MS są równe.
H1: Średnie wyniki PRS i MS są różne.
Przeprowadźmy te testy przy założonym poziomie istotności α=0.05.

__Wyniki testów hipotezowe:__

_Dwa wymiary dla funkcji Ackley:_
p-wartość < 0.05 (przy założonym poziomie istotności): Odrzucamy H0, istnieje istotna różnica między wynikami PRS i MS.

_10 wymiarów dla funkcji Rastrigina:_
p-wartość < 0.05: Odrzucamy H0, istnieje istotna różnica między wynikami PRS i MS.

_20 wymiarów dla funkcji Ackley:_
p-wartość < 0.05: Odrzucamy H0, istnieje istotna różnica między wynikami PRS i MS.

Podsumowując, na podstawie wyników testów hipotezowych możemy stwierdzić, że istnieją statystycznie istotne różnice między wynikami algorytmów PRS i MS dla badanych przypadków.


***Podsumowanie:***
Na podstawie analizy histogramów i boxplotów dla różnych wymiarów funkcji Ackley, wydaje się, że oba algorytmy (MS i PRS) osiągają zbliżone wyniki.
Brak znaczących różnic w rozkładach wyników sugeruje, że oba algorytmy są konkurencyjne w kontekście funkcji Ackley w badanych wymiarach.
Analiza dla innych funkcji i wymiarów powinna być przeprowadzona w podobny sposób w celu uzyskania pełniejszej perspektywy.


#### Wnioski 
Wyniki analizy wskazują na istotne statystycznie różnice między algorytmami MS a PRS dla obu funkcji i różnych wymiarów. Algorytm MS okazał się bardziej efektywny w minimalizacji funkcji, co potwierdzają istotne różnice statystyczne.
