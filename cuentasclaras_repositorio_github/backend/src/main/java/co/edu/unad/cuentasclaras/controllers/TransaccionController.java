package co.edu.unad.cuentasclaras.controllers;

import co.edu.unad.cuentasclaras.dtos.*;
import co.edu.unad.cuentasclaras.services.TransaccionService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/transacciones")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class TransaccionController {

    private final TransaccionService transaccionService;

    @PostMapping("/fiado")
    public ResponseEntity<TransaccionResponseDTO> registrarFiado(
            @Valid @RequestBody CargoFiadoRequestDTO request,
            @RequestAttribute(value = "idTienda", required = false) Long idTienda) {
        Long tienda = (idTienda != null) ? idTienda : 1L;
        TransaccionResponseDTO response = transaccionService.registrarCargoFiado(request, tienda);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @PostMapping("/abono")
    public ResponseEntity<TransaccionResponseDTO> registrarAbono(
            @Valid @RequestBody AbonoRequestDTO request,
            @RequestAttribute(value = "idTienda", required = false) Long idTienda) {
        Long tienda = (idTienda != null) ? idTienda : 1L;
        TransaccionResponseDTO response = transaccionService.registrarAbono(request, tienda);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }
}
