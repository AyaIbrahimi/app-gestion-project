import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter } from '@angular/router';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';
import { MembreEquipe } from './membre-equipe';

describe('MembreEquipe', () => {
  let component: MembreEquipe;
  let fixture: ComponentFixture<MembreEquipe>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MembreEquipe],
      providers: [
        provideRouter([]),
        provideHttpClient(),
        provideHttpClientTesting()
      ]
    }).compileComponents();

    fixture = TestBed.createComponent(MembreEquipe);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
