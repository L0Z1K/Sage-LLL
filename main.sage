n = 20689987720283200611801940022454117253676786738100056450509439612141539994818463121976586586988025631132217368036537883232400668425830394989488783251318356865938398747277080709384496595099756703161927776557247295996492369539994654918894967888512603024826347526061671374259074749581566472380451477188677764945559087395747234296895090531681025828163569998956499516757560345137642706367513842834803887048161477135419516637787133253431911197001529987911120151765864760606428121737125285824748061139591237271966675878234870902448902252454740092803801124323967350269115685238489995007444701209088534023758852841475865886457
c = 1958090990045948508742057001850892564169972264655086840420703921998957535451179170782181985585233769909370651795815277049946739588170832840992422926609018528620540290308153988451471572713769537197191790694922868884344932328809273706114021743488910659675444271200468284292171344801211348863848465255249415852986420570291040388062309171777215763744210926291443437198963708194924900750622025730743313786521118123428534456923022326928289524935507678572575854446881760801650283896498450096070408890959255868744668593740929689418540220461747387891690292283081466025161520082038968879729684176024837483764340604449164126992

P.<x> = PolynomialRing(Zmod(n))
f = (x+2^1024)^3-c
f = f/f[f.degree()]

P.<x> = PolynomialRing(ZZ)
f = f.change_ring(ZZ)

X = 2^512
delta = f.degree()
epsilon = RR(1/delta - log(2*X, n))
if epsilon < 0:
    print("epsilon is wrong")
    exit(0)
m = ceil(1/(delta*epsilon))

g = []
for i in range(1,m+1):
    for j in range(delta-1, -1, -1):
        g.append((x*X)**j * n**i * f(x*X)**(m-i))

B = Matrix(delta*m)
for i in range(delta*m):
    for j in range(delta*m):
        B[i,j] = g[i][delta*m-1-j]

B = B.LLL()

new_pol = 0
for i in range(delta*m):
    new_pol += B[0][i]*(x/X)**(delta*m-1-i)

print(new_pol.roots()[0][0])

