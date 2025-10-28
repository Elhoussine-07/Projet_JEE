<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="java.util.List" %> <%@ page import="com.example.model.Product" %> <%@
page import="com.example.model.Student" %> <% List<Product>
  products = (List<Product
    >) request.getAttribute("products"); Student currentUser = (Student)
    session.getAttribute("user"); %>
    <!DOCTYPE html>
    <html lang="fr">
      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Produits à vendre - Plateforme d'échange étudiant</title>
        <link
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
        />
        <link
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
          rel="stylesheet"
        />
        <style>
          .product-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: none;
            border-radius: 15px;
            overflow: hidden;
          }
          .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
          }
          .product-image {
            height: 200px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6c757d;
          }
          .price-tag {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 1.1em;
          }
          .owner-info {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 10px;
            margin-top: 10px;
          }
          .search-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 3rem 0;
            margin-bottom: 3rem;
          }
        </style>
      </head>
      <body>
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
          <div class="container">
            <a class="navbar-brand" href="index.jsp">
              <i class="fas fa-graduation-cap me-2"></i>Échange Étudiant
            </a>
            <button
              class="navbar-toggler"
              type="button"
              data-bs-toggle="collapse"
              data-bs-target="#navbarNav"
            >
              <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
              <ul class="navbar-nav me-auto">
                <li class="nav-item">
                  <a class="nav-link active" href="${pageContext.request.contextPath}/products">
                    <i class="fas fa-shopping-cart me-1"></i>Ventes
                  </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="${pageContext.request.contextPath}/donations.jsp">
                    <i class="fas fa-gift me-1"></i>Dons
                  </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="${pageContext.request.contextPath}/lostFound.jsp">
                    <i class="fas fa-search me-1"></i>Objets trouvés
                  </a>
                </li>
              </ul>
              <ul class="navbar-nav">
                <% if (currentUser != null) { %>
                <li class="nav-item dropdown">
                  <a
                    class="nav-link dropdown-toggle"
                    href="#"
                    id="navbarDropdown"
                    role="button"
                    data-bs-toggle="dropdown"
                  >
                    <i class="fas fa-user me-1"></i><%= currentUser.getName() %>
                  </a>
                  <ul class="dropdown-menu">
                    <li>
                      <a class="dropdown-item" href="productForm.jsp"
                        >Ajouter un produit</a
                      >
                    </li>
                    <li>
                      <a class="dropdown-item" href="donationForm.jsp"
                        >Ajouter un don</a
                      >
                    </li>
                    <li>
                      <a class="dropdown-item" href="lostFoundForm.jsp"
                        >Signaler un objet</a
                      >
                    </li>
                    <li><hr class="dropdown-divider" /></li>
                    <li>
                      <a class="dropdown-item" href="auth/logout"
                        >Déconnexion</a
                      >
                    </li>
                  </ul>
                </li>
                <% } else { %>
                <li class="nav-item">
                  <a class="nav-link" href="login.jsp">
                    <i class="fas fa-sign-in-alt me-1"></i>Connexion
                  </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="register.jsp">
                    <i class="fas fa-user-plus me-1"></i>Inscription
                  </a>
                </li>
                <% } %>
              </ul>
            </div>
          </div>
        </nav>

        <!-- Search Section -->
        <section class="search-section">
          <div class="container">
            <div class="row">
              <div class="col-lg-8 mx-auto text-center">
                <h1 class="display-5 mb-4">
                  <i class="fas fa-shopping-cart me-3"></i>Produits à vendre
                </h1>
                <p class="lead mb-4">
                  Découvrez les objets vendus par vos camarades étudiants
                </p>

                <div class="row">
                  <div class="col-md-8 mx-auto">
                    <div class="input-group">
                      <input
                        type="text"
                        class="form-control form-control-lg"
                        placeholder="Rechercher un produit..."
                      />
                      <button class="btn btn-light btn-lg" type="button">
                        <i class="fas fa-search"></i>
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        <!-- Products Section -->
        <section class="py-5">
          <div class="container">
            <div class="row mb-4">
              <div class="col-md-6">
                <h3>Produits disponibles</h3>
              </div>
              <div class="col-md-6 text-end">
                <% if (currentUser != null) { %>
                <a href="productForm.jsp" class="btn btn-primary">
                  <i class="fas fa-plus me-2"></i>Ajouter un produit
                </a>
                <% } else { %>
                <a href="login.jsp" class="btn btn-outline-primary">
                  <i class="fas fa-sign-in-alt me-2"></i>Connectez-vous pour
                  vendre
                </a>
                <% } %>
              </div>
            </div>

            <% if (products != null && !products.isEmpty()) { %>
            <div class="row">
              <% for (Product product : products) { %>
              <div class="col-lg-4 col-md-6 mb-4">
                <div class="card product-card h-100">
                  <div class="product-image">
                    <% if (product.getImages() != null &&
                    !product.getImages().isEmpty()) { %>
                    <img
                      src="<%= product.getImages().get(0).getFilepath() %>"
                      class="card-img-top"
                      alt="<%= product.getName() %>"
                      style="height: 100%; object-fit: cover"
                    />
                    <% } else { %>
                    <i class="fas fa-image fa-3x"></i>
                    <% } %>
                  </div>
                  <div class="card-body">
                    <h5 class="card-title"><%= product.getName() %></h5>
                    <p class="card-text text-muted">
                      <%= product.getDescription() %>
                    </p>
                    <div
                      class="d-flex justify-content-between align-items-center"
                    >
                      <span class="price-tag"
                        ><%= product.getPrice() %> DH</span
                      >
                      <small class="text-muted">
                        <i class="fas fa-user me-1"></i><%=
                        product.getOwner().getName() %>
                      </small>
                    </div>
                    <div class="owner-info">
                      <small class="text-muted">
                        <i class="fas fa-graduation-cap me-1"></i><%=
                        product.getOwner().getFiliere() %> <% if
                        (product.getOwner().getPhone() != null &&
                        !product.getOwner().getPhone().isEmpty()) { %> <br /><i
                          class="fas fa-phone me-1"
                        ></i
                        ><%= product.getOwner().getPhone() %> <% } %>
                      </small>
                    </div>
                  </div>
                  <div class="card-footer bg-transparent">
                    <div class="d-grid">
                      <button class="btn btn-outline-primary">
                        <i class="fas fa-eye me-2"></i>Voir détails
                      </button>
                    </div>
                  </div>
                </div>
              </div>
              <% } %>
            </div>
            <% } else { %>
            <div class="text-center py-5">
              <i class="fas fa-shopping-cart fa-4x text-muted mb-4"></i>
              <h4 class="text-muted">Aucun produit disponible</h4>
              <p class="text-muted">
                Soyez le premier à mettre en vente un produit !
              </p>
              <% if (currentUser != null) { %>
              <a href="productForm.jsp" class="btn btn-primary">
                <i class="fas fa-plus me-2"></i>Ajouter un produit
              </a>
              <% } else { %>
              <a href="login.jsp" class="btn btn-outline-primary">
                <i class="fas fa-sign-in-alt me-2"></i>Se connecter
              </a>
              <% } %>
            </div>
            <% } %>
          </div>
        </section>

        <!-- Footer -->
        <footer class="bg-dark text-light py-4">
          <div class="container text-center">
            <p>
              &copy; 2024 Plateforme d'échange étudiant. Tous droits réservés.
            </p>
          </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
      </body>
    </html> </Product
></Product>
